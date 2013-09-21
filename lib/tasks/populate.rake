namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		10.times do |n|
			puts "[DEBUG] creating user #{n+1} of 10"
			name = Faker::Name.name
			email = "user-#{n+31}@example.com"
			password = "password"
			User.create!( name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end

		User.all.each do |user|
			puts "[DEUBG] uploading images for user #{user.id} of #{User.last.id}"
			10.times do |n|
				image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
				description = %w(cool awesome crazy wow adroable incredible).sample
				user.pins.create!(image: image, description: description)
			end
		end
	end
end