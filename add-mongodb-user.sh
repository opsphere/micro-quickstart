#!/bin/bash

mongo <<EOF
use admin;
db.createUser({ user: "jcloud_fs" , pwd: "abcd.1234", roles: ["userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]});
EOF
