require 'highline'

namespace :user do
  desc 'add an user'
  task :add => :environment do
    cli = HighLine.new
    name = ENV['username'] || cli.ask('username: ')
    pass = ENV['password'] || cli.ask('password: ') { |q| q.echo = false }
    @user = User.create(name: name, password: pass)
    if (@user.nil? || !@user.valid?)
      puts "User is nil or not valid!: #{@user.errors.inspect} "
      return
    end
    props_json = <<EOS
      {
        "supported-calendar-component-set": "<CALDAV:comp name=\\"VEVENT\\" />"
      }
EOS
    Calendar.create(props_json: props_json, uri: 'Private', user: @user)

    props_json = <<EOS
      {
        "supported-calendar-component-set": "<CALDAV:comp name=\\"VTODO\\" />"
      }
EOS
    Calendar.create(props_json: props_json, uri: 'ToDo', user: @user)
  end

  desc 'delete an user'
  task :delete => :environment do
    cli = HighLine.new
    name = ENV['name'] || cli.ask('username: ')
    User.find_by_name!(name).delete
  end

  desc 'list users'
  task :list => :environment do
    puts "User, #Calendars, #Events"
    User.all.each do |u|
      puts "#{u.name}, #{u.calendars.count}, #{u.schedules.count}"
    end
  end
end
