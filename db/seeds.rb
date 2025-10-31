# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  cv = Cv.create(
    name:          "Riccardo Giomi",
    email_address: "riccardo.giomi.contact@gmail.com",
    notes:         "Initial CV for development",
    intro_line:    "Software Engineer (currently RoR)",
    intro_text:    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nMauris quis mauris nec mauris mollis egestas non vel dolor.\n Donec consequat ipsum in leo scelerisque aliquet.\n Nam feugiat consectetur feugiat.\n Pellentesque ut tempor dui.\n Etiam nulla lacus, consectetur eu condimentum sit amet, venenatis sed nisl.\n Aenean porttitor a nisl a aliquam.\n Donec dictum massa eu purus hendrerit, quis semper nibh bibendum.\n In tempor porta tortor, ac imperdiet ex tempor nec.\n Donec sit amet tincidunt libero, nec viverra eros.\n Etiam tellus enim, bibendum sit amet condimentum nec, molestie eget augue.\n Etiam et iaculis libero.\n Fusce ac dignissim mi.\n Integer at consequat turpis.\n Suspendisse vel nibh a magna tincidunt faucibus.\n",
    base_filename: "cv.en",
    language:      "English"
  )
  cv.contacts << Contact.create(
    contact_type: "github",
    value:        "github.com/riccardo-giomi",
    position:     1
  )
  cv.contacts << Contact.create(
    contact_type: "linkedin",
    value:        "linkedin.com/in/riccardo-giomi-663303188",
    position:     2
  )
  cv.education_items << EducationItem.create(
    name:     "Batchelor degree in Computer Engineering",
    location: "School of Engineering, University of Pisa, Italy.",
    date:     "2007",
    position: 1
  )
  cv.languages << Language.create(
    name:     "English",
    level:    "professional",
    position: 1
  )
  cv.languages << Language.create(
    name:     "Italian",
    level:    "native",
    position: 2
  )
  cv.languages << Language.create(
    name:     "Spanish",
    level:    "intermediate",
    position: 3
  )
  cv.work_experiences << WorkExperience.create(
    title:       "Software Engineer",
    entity:      "betterplace.org",
    entity_uri:  "www.betterplace.org/en",
    period:      "2022-2024",
    description: "betterplace.org is an organization that helps ONGs and private citizens to collect donations for social causes. betterplace.org is currently growing and moving to agile practices and a continuos delivery model. I am currently part of this evolution as part of the Engineering team, specifically as a back-end developer with a strong focus on testing and delivery of quality features.",
    tags:        "Ruby,Ruby on Rails,MySQL,PostgreSQL,GraphQL",
    position: 1
  )
  cv.work_experiences << WorkExperience.create(
    title:       "Senior developer",
    entity:      "MMO",
    entity_uri:  "www.makemoneyorganization.com",
    period:      "2021",
    description: "Member of the team developing the internal management application for Make Money Organization, a Professional Training & Coaching company for Real Estate agents.",
    tags:        "Vue,PHP/Symphony",
    position: 2
  )
end
