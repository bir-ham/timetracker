# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago'  }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first

customers = Customer.create([{ name: 'Customer1', phone_number: '+358542066330' , email: 'customer1@gmail.com', address: 'Address 1, 02230 Espoo' },
  { name: 'Customer2', phone_number: '+358542066331', email: 'customer2@gmail.com', address: 'Address 2, 02230 Espoo' },
  { name: 'Customer3', phone_number: '+358542066332', email: 'customer3@gmail.com', address: 'Address 3, 02230 Espoo' },
  { name: 'Customer4', phone_number: '+358542066333', email: 'customer4@gmail.com', address: 'Address 4, 02230 Espoo' }])

projects = Project.create([{ name: 'Project1', deadline: Date.today, user: user, customer: customers[0], status: 'NEW', description: 'Project1 description' },
  {name: 'Project2', deadline: Date.today, user: user, customer: customers[2], status: 'ONGOING', description: 'Project2 description' },
  {name: 'Project3', deadline: Date.today, user: user, customer: customers[2], status: 'NEW', description: 'Project3 description' },
  {name: 'Project4', deadline: Date.today, user: user, customer: customers[3], status: 'FINISHED', description: 'Project4 description' },
  {name: 'Project5', deadline: Date.today, user: user, customer: customers[0], status: 'FINISHED', description: 'Project5 description' },
  {name: 'Project6', deadline: Date.today, user: user, customer: customers[3], status: 'ONGOING', description: 'Project6 description' },
  {name: 'Project7', deadline: Date.today, user: user, customer: customers[0], status: 'DELAYED', description: 'Project7 description' },
  {name: 'Project8', deadline: Date.today, user: user, customer: customers[1], status: 'ONGOING', description: 'Project8 description' },
  {name: 'Project9', deadline: Date.today, user: user, customer: customers[0], status: 'FINISHED', description: 'Project9 description' },
  {name: 'Project10', deadline: Date.today, user: user, customer: customers[3], status: 'DELAYED', description: 'Project10 description' },
  {name: 'Project11', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project11 description' }])

tasks = Task.create([{ name: 'Design', hours: '2:15', payment_type: 'Per task', price: 5, vat: 15, project: projects[0], total: 5 },
  { name: 'Typing', hours: '3:00', payment_type: 'Per task', price: 15, vat: 15, project: projects[1], total: 15 },
  { name: 'Translation', hours: '1:00', payment_type: 'Per task', price: 2.50, vat: nil, project: projects[4], total: 2.50 },
  { name: 'Typing', hours: '4:50', payment_type: 'Per hour', price: 5, vat: 15, project: projects[3], total: 24.16 },
  { name: 'Printing', hours: '3:15', payment_type: 'Per hour', price: 5, vat: 15, project: projects[5], total: 16.25 },
  { name: 'Binding', hours: '4:15', payment_type: 'Per hour', price: 3.5, vat: 15, project: projects[8], total: 14.87 }])

sales = Sale.create([{ date: Date.today, user: user, customer: customers[0], status: 'DELIVERED', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[0], status: 'PREPARING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[1], status: 'PREPARING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[3], status: 'DELIVERED', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[1], status: 'DELIVERED', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[2], status: 'WAITING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[0], status: 'WAITING', description: 'Sale description' }])

items = Item.create([{ name: 'Pencil', quantity: 2, unit: 'Piece', unit_price: 5, vat: 15, sale: sales[0], total: 10 },
  { name: 'Book', quantity: 2, unit: 'Piece', unit_price: 15, vat: 15, sale: sales[1], total: 30 },
  { name: 'Ruler', quantity: 1, unit: 'Piece', unit_price: 2.50, vat: nil, sale: sales[2], total: 2.50 },
  { name: 'Sugar', quantity: 4, unit: 'Kilo gram', unit_price: 5, vat: 15, sale: sales[3], total: 20 },
  { name: 'Wheate', quantity: 3, unit: 'Kilo gram', unit_price: 5, vat: 15, sale: sales[4], total: 15 },
  { name: 'Sesame', quantity: 4, unit: 'Kilo gram', unit_price: 3.5, vat: 15, sale: sales[5], total: 14 }])

invoices = Invoice.create([{ user: user, sale: sales[0], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'PENDING', reference_number: '54321', description: 'Invoice description' },
  { user: user, sale: sales[3], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'OVERDUE', reference_number: '54324', description: 'Invoice description' },
  { user: user, project: projects[3], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'OVERDUE', reference_number: '54327', description: 'Invoice description' },
  { user: user, project: projects[4], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'PENDING', reference_number: '54328', description: 'Invoice description' },
  { user: user, project: projects[8], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'PAID', reference_number: '54329', description: 'Invoice description' },
  { user: user, sale: sales[4], date_of_an_invoice: Date.today, deadline: Date.tomorrow, status: 'PAID', reference_number: '54313', description: 'Invoice description' }])