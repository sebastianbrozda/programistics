# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

NoteType.create([
                    {id: NoteType::TYPE_PUBLIC, name: 'public', description: 'Note is visible for everyone.'},
                    {id: NoteType::TYPE_PRIVATE, name: 'private', description: 'Note is visible ONLY for you.'},
                    {id: NoteType::TYPE_PAID_ACCESS, name: 'paid access', description: 'User must pay you to see this note.'}])

Currency.create({name: 'USD', price: 0})