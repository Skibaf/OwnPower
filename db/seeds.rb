# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#


User.create(username:'susi@gmail.com',
             email:'susi@gmail.com', 
              password:'123456',
             password_confirmation:'123456', 
             fisrt_name:'Su', 
             last_name:'Kilo', 
             role:User.roles[:user])


User.create(username:'julif@gmail.com',
            email:'julif@gmail.com', 
              password:'123456',
             password_confirmation:'123456', 
             fisrt_name:'July', 
             last_name:'Ferraro', 
             role:User.roles[:coach])

User.create(username:'peterc@gmail.com',
             email:'peterc@gmail.com', 
             password:'123456',
            password_confirmation:'123456', 
            fisrt_name:'Peter', 
            last_name:'Cal', 
            role:User.roles[:coach])

User.create(username:'skiba_flo@gmail.com',
             email:'skiba_flo@gmail.com', 
             password:'123456',
            password_confirmation:'123456', 
            fisrt_name:'Flo', 
            last_name:'CSki', 
            role:User.roles[:admin])

 User.create(username:'melii@gmail.com',
             email:'melii@gmail.com', 
              password:'123456',
             password_confirmation:'123456', 
             fisrt_name:'Melisa', 
             last_name:'Gorsh', 
             role:User.roles[:user])

Category.create(title:'Funcional', description: 'Diseñado para mejorar en general el estado fisico ', status:Category.statuses[:activa])
Category.create(title:'Running', description: 'Preparacion de carreras ', status:Category.statuses[:activa])
Category.create(title:'Recove', description: 'Preparado para volver .... ', status:Category.statuses[:activa])