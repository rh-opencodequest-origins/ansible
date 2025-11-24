#!/bin/bash

echo "Cleaning argocd rhdh-gitops"
oc get Application -n rhdh-gitops -o yaml|yq '.items.[].metadata.name' | xargs oc -n rhdh-gitops delete Applications
oc get AppProjects -n rhdh-gitops -o yaml|yq '.items.[].metadata.name' | xargs oc -n rhdh-gitops delete AppProjects

echo

echo "Cleaning showroom"
oc get ApplicationSet  -n openshift-gitops         | grep showroom       | awk '{print $1}' | xargs oc -n openshift-gitops delete ApplicationSet  
oc get Applications    -n openshift-gitops         | grep showroom-team  | awk '{print $1}' | xargs oc -n openshift-gitops delete Applications

echo

echo "Cleaning other apps"
oc get Applications -n openshift-gitops | grep -e rhdh-team-bootstrap -e rhdh-team -e rhdh-gitops -e gitlab -e keycloak -e vault -e quay -e rbac -e sonarqube | awk '{print $1}' | xargs oc -n openshift-gitops delete Applications

echo

echo "Cleaning projects/namespaces"
oc get project | grep -e workshop -e showroom-team -e rhdh-team -e gitlab -e keycloak -e vault -e quay-registry -e rhdh-gitops | awk '{ print $1 }' | xargs oc delete project 

echo

echo "Cleaning Dev Spaces"
oc get project -o json|jq -r '.items.[].metadata.name' | grep devspaces | grep -v openshift-devspaces | while read ns
do
  oc delete project $ns
done

echo

echo "GitLab App secret"
oc get secret gitlab-oauth-config -n openshift-devspaces >/dev/null 2>&1 && oc delete secret gitlab-oauth-config -n openshift-devspaces 

echo

echo "Cleaning users"
oc get users -o json | jq -r '.items.[].metadata.name' | grep -v admin | while read user
do
  oc delete user $user
done
