require 'rubygems'
require 'xeroizer'

# reads this from the CONSUMER_KEY file in the root of the project.
CONSUMER_KEY = IO.read('CONSUMER_KEY').chomp
# no need for customer secret when using rsa
CONSUMER_SECRET = nil

# dates can be either a iso8601 string or nil
START = "2007-01-01T00:00:00"
FINISH = "2008-07-09T00:00:00"

# create params for the query.
arg = {}.tap do |a|
  where = ""
  where += "Date>=DateTime.Parse(\"#{START}\")" if START
  where += "&&" unless where.empty?
  where += "Date<=DateTime.Parse(\"#{FINISH}\")" if FINISH
  a[:where] = where unless where.empty?
end

# Create client (used to communicate with the API).
client = Xeroizer::PrivateApplication.new(CONSUMER_KEY, CONSUMER_SECRET, 'rsa')

results = client.Invoice.all(arg)
results.each do |c|
  p c
end
