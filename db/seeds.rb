# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.

Channel.create(approved: true,name: "Philosoc", description: "Philosophy Club of IIIT Delhi", post_type: :public, rss_link: "https://philosocblog.wordpress.com/feed/")
Channel.create(approved: true,name: "Gamecraft", description: "Game Development Club of IIIT Delhi", post_type: :public, rss_link: "https://gamecraftiiitd.wordpress.com/feed/")
Channel.create(approved: true,name: "Byld Blog", description: "Blog of the Development Club of IIIT Delhi", post_type: :public, rss_link: "http://byld.iiitd.edu.in/blog/rss/")
Channel.create(approved: true,name: "Byld", description: "Development Club of IIIT Delhi", post_type: :members)
Channel.create(approved: true,name: "IIIT Delhi", description: "Official Channel of IIIT Delhi", post_type: :forced)
Channel.create(approved: true,name: "Find My Stuff", description: "Lost and found portal of IIIT Delhi", post_type: :forced)