#!/bin/bash

oc delete Applications devteam1-hero-bootstrap devteam1-hero-dev devteam1-hero-dev-build devteam1-hero-preprod devteam1-hero-prod -n rhdh-gitops
oc delete AppProjects devteam1-hero-bootstrap -n rhdh-gitops

oc delete project devteam1-workshop-dev devteam1-workshop-preprod devteam1-workshop-prod




oc delete Applications rhdh-team{1..5} rhdh-team{1..5}-bootstrap rhdh-gitops gitlab keycloak vault quay -n openshift-gitops
oc delete project rhdh-team{1..5}  gitlab keycloak vault quay-registry rhdh-gitops 

