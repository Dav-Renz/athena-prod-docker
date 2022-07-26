#!/bin/bash

# general alt:V server options
ALTV_SERVER_NAME=${ALTV_SERVER_NAME:-"Athena Server on Docker!"}
ALTV_SERVER_HOST=${ALTV_SERVER_HOST:-"0.0.0.0"}
ALTV_SERVER_ENVIRONMENT=${ALTV_SERVER_ENVIRONMENT:-"prod"}
ALTV_SERVER_PORT=${ALTV_SERVER_PORT:-"7788"}
ALTV_SERVER_PLAYERS=${ALTV_SERVER_PLAYERS:-"512"}
ALTV_SERVER_PASSWORD=${ALTV_SERVER_PASSWORD:-"null"}
ALTV_SERVER_TOKEN=${ALTV_SERVER_TOKEN:-"null"}
ALTV_SERVER_ANNOUNCE=${ALTV_SERVER_ANNOUNCE:-"false"}
ALTV_SERVER_GAMEMODE=${ALTV_SERVER_GAMEMODE:-"Roleplay"}
ALTV_SERVER_WEBSITE=${ALTV_SERVER_WEBSITE:-"athenaframework.com"}
ALTV_SERVER_LANGUAGE=${ALTV_SERVER_LANGUAGE:-"en"}
ALTV_SERVER_DESCRIPTION=${ALTV_SERVER_DESCRIPTION:-"An Athena Alt:V server running in a Docker container."}
ALTV_SERVER_DEBUG=${ALTV_SERVER_DEBUG:-"true"}
ALTV_SERVER_STREAMING_DISTANCE=${ALTV_SERVER_STREAMING_DISTANCE:-"400"}
ALTV_SERVER_MIGRATION_DISTANCE=${ALTV_SERVER_MIGRATION_DISTANCE:-"150"}
ALTV_SERVER_TIMEOUT=${ALTV_SERVER_TIMEOUT:-"1"}
ALTV_SERVER_ANNOUNCE_RETRY_ERROR_DELAY=${ALTV_SERVER_ANNOUNCE_RETRY_ERROR_DELAY:-"10000"}
ALTV_SERVER_ANNOUNCE_RETRY_ERROR_ATTEMPTS=${ALTV_SERVER_ANNOUNCE_RETRY_ERROR_ATTEMPTS:-"50"}
ALTV_SERVER_MODULES=${ALTV_SERVER_MODULES:-""}
ALTV_SERVER_RESOURCES=${ALTV_SERVER_RESOURCES:-""}
ALTV_SERVER_TAGS=${ALTV_SERVER_TAGS:-""}
ALTV_SERVER_USE_EARLYAUTH=${ALTV_SERVER_USE_EARLYAUTH:-"false"}
ALTV_SERVER_EARLYAUTH_URL=${ALTV_SERVER_EARLYAUTH_URL:-"null"}
ALTV_SERVER_USE_CDN=${ALTV_SERVER_USE_CDN:-"false"}
ALTV_SERVER_CDN_URL=${ALTV_SERVER_CDN_URL:-"null"}


# alt:V server voice options
ALTV_SERVER_VOICE_BITRATE=${ALTV_SERVER_VOICE_BITRATE:-"64000"}
ALTV_SERVER_VOICE_EXTERNAL_SECRET=${ALTV_SERVER_VOICE_EXTERNAL_SECRET:-"null"}
ALTV_SERVER_VOICE_EXTERNAL_HOST=${ALTV_SERVER_VOICE_EXTERNAL_HOST:-"null"}
ALTV_SERVER_VOICE_EXTERNAL_PORT=${ALTV_SERVER_VOICE_EXTERNAL_PORT:-"null"}
ALTV_SERVER_VOICE_EXTERNAL_PUBLIC_HOST=${ALTV_SERVER_VOICE_EXTERNAL_PUBLIC_HOST:-"null"}
ALTV_SERVER_VOICE_EXTERNAL_PUBLIC_PORT=${ALTV_SERVER_VOICE_EXTERNAL_PUBLIC_PORT:-"null"}


# Athena options
ATHENA_SERVER_MONGO_URL=${ATHENA_SERVER_MONGO_URL:-"null"}
ATHENA_SERVER_ARES_ENDPOINT=${ATHENA_SERVER_ARES_ENDPOINT:-"null"}
ATHENA_SERVER_USE_ALTV_RECONNECT=${ATHENA_SERVER_USE_ALTV_RECONNECT:-"true"}





if [ ! -z "$ALTV_SERVER_RESOURCES" ]; then
    ALTV_SERVER_RESOURCES="[ \"webviews\", \"core\", $ALTV_SERVER_RESOURCES ]"
else
    ALTV_SERVER_RESOURCES="[ \"webviews\", \"core\"	]"
fi

if [ ! -z "$ALTV_SERVER_MODULES" ]; then
    ALTV_SERVER_MODULES="[ \"js-module\", $ALTV_SERVER_MODULES ]"
else
    ALTV_SERVER_MODULES="[ \"js-module\" ]"
fi

if [ ! -z "$ALTV_SERVER_TAGS" ]; then
    ALTV_SERVER_TAGS="[ \"js-module\", $ALTV_SERVER_TAGS ]"
else
    ALTV_SERVER_TAGS="[ \"athena\", \"framework\", \"version\", \"3\" ]"
fi


git up


cat <<EOF >/opt/altv/athena-server/AthenaConfig.json
{
    "[?] A URI with authentication to connect to a MongoDB Database": "TYPE IS STRING",
    "[?] ex: mongodb://username:password@127.0.0.1:27017": "TYPE IS STRING",
    "MONGO_URL": $ATHENA_SERVER_MONGO_URL,
    "[?] Used for Ares Service Debugging": "TYPE IS STRING",
    "ARES_ENDPOINT": $ATHENA_SERVER_ARES_ENDPOINT,
    "[?] Use altv built-in reconnect?": "TYPE IS BOOLEAN",
    "USE_ALTV_RECONNECT": $ATHENA_SERVER_USE_ALTV_RECONNECT
}
EOF

npm run linux
