#!/usr/bin/env bash


### note!note!note!
## swagger-codegen's server
# http address is :
# http://localhost:${serverPort:=2288}/v2/user # http method is post, body={attr1=v1,attr2=v2}
# http://localhost:${serverPort:=2288}/v2/user/login?username=u1&password=p1
## swagger-codegen's client(front end)
# api:
# https://github.com/swagger-api/swagger-codegen/blob/master/samples/client/petstore/javascript/docs/UserApi.md
# https://github.com/swagger-api/swagger-codegen/blob/master/samples/client/petstore/javascript/README.md
# SwaggerPetstore.ApiClient.instance.basePath


### start
git clone https://github.com/swagger-api/swagger-codegen.git --recursive
cd swagger-codegen
mvn clean package

#
serverPort=2288
hello1Path='/opt/limi/hello-web/assets/hello/swagger/hello1'
mkdir -p ${hello1Path:="/opt/limi/hello-web/assets/hello/swagger/hello1"}

## server
# https://github.com/swagger-api/swagger-codegen/blob/master/samples/server/petstore/nodejs/README.md
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
    -i modules/swagger-codegen/src/test/resources/2_0/petstore.json \
    -l nodejs-server \
    --git-user-id "swaggerapi" \
    --git-repo-id "petstore-nodejs-server" \
    --release-note "Github integration demo" \
    --additional-properties serverPort=${serverPort:=2288} \
    -o ${hello1Path:="/opt/limi/hello-web/assets/hello/swagger/hello1"}/nodejs-server

cd ${hello1Path:="/opt/limi/hello-web/assets/hello/swagger/hello1"}/nodejs-server
npm i
npm run start
#    Your server is listening on port 2288 (http://localhost:2288)
#    Swagger-ui is available on http://localhost:2288/docs
open http://localhost:${serverPort:=2288}/docs
open http://localhost:${serverPort:=2288}/v2/user/login?username=u1&password=p1
open http://localhost:${serverPort:=2288}/v2/user

## client
# https://github.com/swagger-api/swagger-codegen/blob/master/samples/client/petstore/javascript/README.md
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
    -i modules/swagger-codegen/src/test/resources/2_0/petstore.json \
    -l javascript \
    --git-user-id "swaggerapi" \
    --git-repo-id "petstore-javascript" \
    --release-note "Github integration demo" \
    -o ${hello1Path:="/opt/limi/hello-web/assets/hello/swagger/hello1"}/javascript

cd ${hello1Path:="/opt/limi/hello-web/assets/hello/swagger/hello1"}
cat >> hello1.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="./hello1.bundle.js"></script>
</head>
<body>
<div>Hello Swagger</div>
<div id="systemInfoEd"></div>
<div id="dataInfoEd"></div>
</body>
</html>
EOF

cat >> hello1.js <<EOF
var SwaggerPetstore = require('./javascript/src/index');
SwaggerPetstore.ApiClient.instance.basePath = 'http://localhost:${serverPort:=2288}/v2';
var apiInstance = new SwaggerPetstore.UserApi();
var body = new SwaggerPetstore.User(); // User | Created user object
var callback = function(error, data, response) {
    if (error) {
        window.document.getElementById('systemInfoEd').innerHTML = JSON.stringify(error);
        console.error(error);
    }
    else {
        window.document.getElementById('systemInfoEd').innerHTML = JSON.stringify('API called successfully.');
        window.document.getElementById('dataInfoEd').innerHTML = JSON.stringify(data);
        console.log('API called successfully.');
        console.log(data);
    }
};
apiInstance.createUser(body, callback);
EOF

cd javascript
npm i
cd ..
npm install -g browserify
#./node_modules/browserify/bin/cmd.js --debug --entry hello1.js --outfile hello1.bundle.js
browserify --debug hello1.js > hello1.bundle.js

# open hello url in http server host:port e.g.: nginx
open http://localhost:8008/hello-web/assets/hello/swagger/hello1/hello1.html
