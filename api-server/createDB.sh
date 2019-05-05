#/bin/bash

docker run --name weixin_template \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=weixin_template \
-p 5432:5432 \
-d postgres
