# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago'  }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first

customers = Customer.create([{ name: 'Customer1', phone_number: '+358542066330' , email: 'customer1@gmail.com', address: 'Address 1, 02230 Espoo' },
  { name: 'Customer2', phone_number: '+358542066330', email: 'customer2@gmail.com', address: 'Address 2, 02230 Espoo' },
  { name: 'Customer3', phone_number: '+358542066330', email: 'customer3@gmail.com', address: 'Address 3, 02230 Espoo' },
  { name: 'Customer4', phone_number: '+358542066330', email: 'customer4@gmail.com', address: 'Address 4, 02230 Espoo' }])

projects = Project.create([{ name: 'Project1', deadline: Date.today, user: user, customer: customers[0], status: 'NEW', description: 'Project1 description' },
  {name: 'Project2', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project2 description' },
  {name: 'Project3', deadline: Date.today, user: user, customer: customers[0], status: 'NEW', description: 'Project3 description' },
  {name: 'Project4', deadline: Date.today, user: user, customer: customers[0], status: 'FINISHED', description: 'Project4 description' },
  {name: 'Project3', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project3 description' },
  {name: 'Project4', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project4 description' },
  {name: 'Project3', deadline: Date.today, user: user, customer: customers[0], status: 'DELAYED', description: 'Project3 description' },
  {name: 'Project4', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project4 description' },
  {name: 'Project3', deadline: Date.today, user: user, customer: customers[0], status: 'FINISHED', description: 'Project3 description' },
  {name: 'Project4', deadline: Date.today, user: user, customer: customers[0], status: 'DELAYED', description: 'Project4 description' },
  {name: 'Project5', deadline: Date.today, user: user, customer: customers[0], status: 'ONGOING', description: 'Project5 description' }])

sales = Sale.create([{ date: Date.today, user: user, customer: customers[0], status: 'DELIVERED', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[0], status: 'PREPARING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[1], status: 'PREPARING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[3], status: 'NEW', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[4], status: 'NEW', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[0], status: 'WAITING', description: 'Sale description' },
  { date: Date.today, user: user, customer: customers[0], status: 'WAITING', description: 'Sale description' }])

invoices = Invoice.create([{ user: user, sale: sales[0], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54321', description: 'Sale description' },
  { user: user, sale: sales[1], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, sale: sales[2], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, sale: sales[3], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[0], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[1], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[2], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[4], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[5], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, project: projects[6], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54322', description: 'Sale description' },
  { user: user, sale: sales[5], date_of_an_invoice: Date.today, deadline: Date.tomorrow, reference_number: '54323', description: 'Sale description' }])