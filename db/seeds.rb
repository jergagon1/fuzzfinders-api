# User.create(
#   username: "testuser",
#   email: "testuser@example.com",
#   password_hash: "password",
#   zipcode: 12345,
#   wags: 0,
#   reports: [
    Report.create(
      user_id: 1,
      animal_type: "dog",
      lat: 12.34567890,
      lng: 9.87654321,
      report_type: "found",
      notes: "I found this dog",
      img_url: "http://www.example.com/lost_dog.jpg",
      size: "small",
      distance: 10.53,
      tags: [Tag.create(content: "black"), Tag.create(content: "friendly")]
    )
    Report.create(
      user_id: 1,
      pet_name: "ben",
      animal_type: "dog",
      lat: 12.34555555,
      lng: 9.87655555,
      report_type: "lost",
      notes: "I lost my dog ben.",
      img_url: "http://www.example.com/ben.jpg",
      age: "baby",
      breed: "german shephard",
      sex: "male",
      size: "small",
      distance: 0.00,
      tags: [Tag.create(content: "puppy")]
    )
#   ],
# )

# Comment.create(
#   user: User.first,
#   report: Report.first,
#   content: "blah blah blah",
# )
