# frozen_string_literal: true

eli = Customer.create!(first_name: 'eli', last_name: 'sachs', email: 'es@g', address: '2264 Dexter')
joe = Customer.create!(first_name: 'joe', last_name: 'garner', email: 'jg@g', address: '1001 Emerson')
tyler = Customer.create!(first_name: 'tyler', last_name: 'stewart', email: 'ts@g', address: '1055 Logan')
alex = Customer.create!(first_name: 'alex', last_name: 'flev', email: 'af@g', address: '1055 Logan')

chai = Tea.create!(title: 'chai', description: 'sweet', temperature: 100, brew_time: 5)
green = Tea.create!(title: 'green tea', description: 'relaxing', temperature: 120, brew_time: 7)
earl = Tea.create!(title: 'earl grey', description: 'gross', temperature: 110, brew_time: 6)
chamo = Tea.create!(title: 'chamomille', description: 'sleepy', temperature: 130, brew_time: 8)

Subscription.create!(title: 'bundle', price: 5.50, status: 'shipped', frequency: 'weekly', tea: chai, customer: eli)
Subscription.create!(title: 'bundle', price: 4.50, status: 'shipped', frequency: 'weekly', tea: green, customer: eli)
Subscription.create!(title: 'bundle', price: 9.50, status: 'delayed', frequency: 'weekly', tea: chai, customer: joe)
Subscription.create!(title: 'bundle', price: 9.50, status: 'delayed', frequency: 'weekly', tea: green, customer: joe)
Subscription.create!(title: 'earl', price: 9.50, status: 'shipped', frequency: 'monthly', tea: earl, customer: tyler)
Subscription.create!(title: 'chamo', price: 9.50, status: 'delayed', frequency: 'monthy', tea: chamo, customer: alex)
