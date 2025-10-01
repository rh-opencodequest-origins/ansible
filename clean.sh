#!/bin/bash

oc delete Applications devteam{1..5}-hero-bootstrap devteam{1..5}-hero-dev devteam{1..5}-hero-dev-build devteam{1..5}-hero-preprod devteam{1..5}-hero-prod -n rhdh-gitops
oc delete ApplicationSet showroom -n openshift-gitops
oc delete Applications showroom-team{1..5} -n openshift-gitops
oc delete AppProjects devteam{1..5}-hero-bootstrap -n rhdh-gitops

oc delete project devteam{1..5}-workshop-dev devteam{1..5}-workshop-preprod devteam{1..5}-workshop-prod showroom-team{1..5}




oc delete Applications rhdh-team{1..5} rhdh-team{1..5}-bootstrap rhdh-gitops gitlab keycloak vault quay rbac sonarqube  -n openshift-gitops
oc delete project rhdh-team{1..5}  gitlab keycloak vault quay-registry rhdh-gitops 

oc get project -o json|jq -r '.items.[].metadata.name' | grep devspaces | grep -v openshift-devspaces | while read ns
do
  oc delete project $ns
done

oc get users -o json | jq -r '.items.[].metadata.name' | grep -v admin | while read user
do
  oc delete user $user
done
