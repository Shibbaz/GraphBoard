# GraphBoard

## Introduction To Apollo Federation concept
Apollo Federation is a powerful, open architecture for creating a supergraph that combines multiple GraphQL APIs. 
With federation, you can responsibly share ownership of your supergraph across any number of teams and services. 
And even if you currently only have one GraphQL API, Apollo Federation is essential for scaling that API as you grow your features, user base, and organization.

# How it works
In a federated architecture, your individual GraphQL APIs are called subgraphs, and they're composed into a supergraph. 
By querying your supergraph's router, clients can fetch data from all of your subgraphs with a single request.
The router serves as the public access point for your supergraph. It receives incoming GraphQL operations and intelligently routes them across your subgraphs. 
To clients, this looks exactly the same as querying any other GraphQL server—no client-side configuration is required.

## Introduction into Project
This project is gonna  consist of 4 services
- [x] Authentication (services/users) -> authenticate user
- [x] Upload (services/storage) -> to Minio -> upload content
- [x] Job Offers (services/recruitment) -> apply to job offer
- [x] Video streaming - > streaming video files that were uploaded throguh services/storage

## Thoughts
Currently Gateway through typescript && nodejs, but eventually We desire performance, so maybe Rust?
Lets have a look at that language later. It's good because services can be developed in other frameworks and even languages.
The only requirement is to have graphql server library in that language that supports graphql federation feature. So Rust, Go, Ruby, javascript.
There is idea that to seperate streaming videos outside the router and create next to router for this kind of thing. 

## Draft of architecture.
![Zrzut ekranu 2023-06-23 002441](https://github.com/Shibbaz/GraphBoard/blob/main/.excalidraw.png)


## How to Run
# Credentials
  - [x] EDITOR=vim rails credentials:edit
  - [x] Copy secret_key_base from credentials on users/service
  - [x] Paste it as users_service_secret_key_base in credentials of services recruitment and storage
  - [x] Add credentials S3_Endpoint, S3_User_Name, S3_SECRET_KEY in storage service credentials

# minio server
  - [x] install minio https://www.digitalocean.com/community/tutorials/how-to-set-up-minio-object-storage-server-in-standalone-mode-on-ubuntu-20-04
  - [x] run server

 # Initialize all services instances
  - [x] rails db:create
  - [x] rails db:migrate
  - [x] rails s -p $port

# Run Gateway
- [x] go gateway/ and run ts-node index.ts
      
# Default Ip adresses of subgraphs, once configured use rails s $port => those $ports accordingly assigned to the service.
  - [x] recruitments: http://localhost:3002/graphql
  - [x] users: http://localhost:3001/graphql
  - [x] storages: http://localhost:3000/graphql
