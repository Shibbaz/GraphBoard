export function PrintServiceDetails(http:any){
    console.log("")
    if (http.url == "http://localhost:3002/graphql"){
        console.log("service: recruitments");
    }
    if (http.url == "http://localhost:3001/graphql"){
        console.log("service: users");
    }
    if (http.url == "http://localhost:3000/graphql"){
        console.log("service: storages");
    }
    console.log(http.headers)
}