#!/usr/bin/env bash

id="$1"
query="$(curl -s https://open-vsx.org/api/$id)"
type="openvsx"
namespace="$(echo $query | jq --raw-output '.namespace')"
if [ "$namespace" = "null" ]; then exit 1; fi
extension="$(echo $query | jq --raw-output '.name')"
license="$(echo $query | jq --raw-output '.license')"
repo="$(echo $query | jq --raw-output '.repository')"
description="$(echo $query | jq --raw-output '.description')"
echo "[$extension]"
echo "src.$type = \"$namespace.$extension\""
echo "fetch.$type = \"$namespace.$extension\""
echo "passthru = { license = \"${license,,}\", homepage = \"$repo\", description = \"$description\" }"
echo ""
