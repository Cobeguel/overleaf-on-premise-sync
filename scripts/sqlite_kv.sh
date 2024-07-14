#!/bin/bash

DATABASE="overleaf-mapper.db"

function create_table() {
    sqlite3 $DATABASE <<EOF
CREATE TABLE IF NOT EXISTS projects (
    id TEXT PRIMARY KEY NOT NULL,
    name TEXT UNIQUE NOT NULL
);
EOF
}

function show_all() {
    sqlite3 $DATABASE "SELECT * FROM projects;"
}

function put_kv() {
    local id=$1
    local name=$2
    sqlite3 $DATABASE <<EOF
INSERT OR REPLACE INTO projects (id, name) VALUES ('$id', '$name');
EOF
}

function get_kv_by_id() {
    local id=$1
    sqlite3 $DATABASE "SELECT name FROM projects WHERE id='$id';"
}

function get_kv_by_name() {
    local name=$1
    sqlite3 $DATABASE "SELECT id FROM projects WHERE name='$name';"
}

function delete_kv() {
    local id=$1
    sqlite3 $DATABASE "DELETE FROM projects WHERE id='$id';"
}

case $1 in
    create)
        create_table
        ;;
    show)
        show_all
        ;;
    put)
        put_kv $2 $3
        ;;
    get_by_id)
        get_kv_by_id $2
        ;;
    get_by_name)
        get_kv_by_name $2
        ;;
    delete)
        delete_kv $2
        ;;
    *)
        echo "Usage: $0 {create|show|put|get_by_id|get_by_name|delete} [args...]"
        ;;
esac