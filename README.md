# Graphs-Demo

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
- [] Upload (services/storage) -> to Minio -> upload content
- [] Job Offers (services/recruitment) -> apply to job offer
- [] Video streaming - > streaming video files that were uploaded throguh services/storage

## Thoughts
Currently Gateway through typescript && nodejs, but eventually We desire performance, so maybe Rust?
Lets have a look at that language later. It's good because services can be developed in other frameworks and even languages.
The only requirement is to have graphql server library in that gem that supports graphql federation feature. So Rust, Go, Ruby, javascript.
There is idea that to seperate streaming videos outside the router and create next to router for this kind of thing. 

## Draft of architecture.
![Zrzut ekranu 2023-06-23 002441](https://github.com/Shibbaz/Graphs-Demo/assets/107750344/b359692b-bb1a-47e0-b682-19d9f9de972a)
