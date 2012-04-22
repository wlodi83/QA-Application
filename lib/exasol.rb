require 'rubygems'
require 'dbi'

class Exasol

  @@admin_email = "lukasz.wlodarczyk@sponsorpay.com"

  def initialize(login, password)
    @login = login
    @password = password
  end

  def connect
    begin
      #connect to the Exasol Server
      @dbh = DBI.connect('dbi:ODBC:EXA', @login, @password)
    rescue DBI::DatabaseError => e
      puts "An error occured"
      puts "Error code: #{e.err}"
      puts "Error message: #{e.errstr}"
      err_message = "#{e.errstr}"
      AlertMailer.send_alert(@@admin_email, err_message).deliver
    ensure
      @dbh.disconnect if @dbh
    end
  end

  def disconnect
    #disconnect from server
    @dbh.disconnect if @dbh
  end

  def do_query(query)
    q = Script.find(query.id)
    begin
      @sth = @dbh.prepare(q.query)
      @sth.execute
    rescue DBI::DatabaseError => e
      puts "An error occured"
      puts "Error code: #{e.err}"
      puts "Error message: #{e.errstr}"
      err_message = "#{e.errstr}"
      AlertMailer.send_alert(@@admin_email, err_message).deliver
    ensure
      @dbh.disconnect if @dbh
    end
  end

  def check_query(id)
    begin
      q = Script.find(id)
      @users = User.joins(:scripts).where(:scripts => {:id => q.id})
      @sth = @dbh.prepare(q.query)
      @sth.execute
    rescue DBI::DatabaseError => e
      puts "An error occurred"
      puts "Error code: #{e.err}"
      puts "Error message: #{e.errstr}"
      q.update_attributes(:err_message => "#{e.errstr}", :active => false)
      err_message = "Something is wrong with your query #{q.title}. Error message: #{e.errstr}"
      @users.each do |user|
        AlertMailer.send_alert(user.email, err_message).deliver
      end
    ensure
      @dbh.disconnect if @dbh
    end
  end

  def print_column_names
    @column_array = Array.new
    @column_array.push(@sth.column_names)
    return @column_array
  end

  def return_number_of_headers
    return @column_array[0].size
  end

  def print_result_array
    @result_array = Array.new
    while row=@sth.fetch_array do
      @result_array.push(row)
    end
    @sth.finish
    return @result_array
  end

end

=begin
connection = Exasol.new('dbi:ODBC:EXA','lwlodarczyk','lwl0d4rczyk')
connection.connect
connection.do_query('1')
connection.print_column_names
connection.return_number_of_headers
connection.print_result_array
connection.disconnect
=end