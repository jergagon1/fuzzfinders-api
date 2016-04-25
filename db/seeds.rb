User.create(
  username: "testuser",
  email: "testuser@example.com",
  password: "password",
  password_confirmation: "password",
  zipcode: 12345,
  wags: 0
)

Report.create(
  user: User.first,
  animal_type: "dog",
  lat: 12.34567890,
  lng: 9.87654321,
  report_type: "found",
  notes: "I found this dog",
  img_url: "http://www.example.com/lost_dog.jpg",
  pet_size: "small",
  distance: 10.53,
  breed: "golden retriever",
  color: "yellow"
)

Report.create(
  user: User.first,
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
  pet_size: "small",
  distance: 0.00,
  color: "brown"
)

Comment.create(
  user: User.first,
  report: Report.first,
  content: "blah blah blah"
)
