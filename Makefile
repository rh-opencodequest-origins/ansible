# Makefile for Ansible Platform Engineering Workshop

# Default cluster value
CLUSTER ?= atlantis

# Playbook path
PLAYBOOK = playbooks/ocp4_workload_platform_engineering_workshop.yml
INFRA_PLAYBOOK = playbooks/ocp4_workload_platform_engineering_workshop_infra_cluster.yaml

# Default action
ACTION ?= create

.PHONY: help cluster atlantis central gotham madripoor wakanda infra metropolis

help:

atlantis: CLUSTER=atlantis
atlantis: cluster

central: CLUSTER=central
central: cluster

gotham: CLUSTER=gotham
gotham: cluster

madripoor: CLUSTER=madripoor
madripoor: cluster

metropolis: CLUSTER=metropolis
metropolis: cluster

wakanda: CLUSTER=wakanda
wakanda: cluster


cluster:
	@start=$$(date); \
	ansible-playbook $(PLAYBOOK) -e ACTION=create -e cluster=$(CLUSTER); \
	end=$$(date); \
	echo "Start at $$start"; \
	echo "End   at $$end"

infra: 
	ansible-playbook $(INFRA_PLAYBOOK) -e ACTION=create

clean:
	./clean.sh

showroom:
	for i in $$(seq 1 6); do \
		tkn pipeline start showroom-team$$i -n showroom-team$$i --last; \
	done

clean_quay_atlantis: CLUSTER=atlantis
clean_quay_atlantis: clean_quay

clean_quay_central: CLUSTER=central
clean_quay_central: clean_quay

clean_quay_gotham: CLUSTER=gotham
clean_quay_gotham: clean_quay

clean_quay_madripoor: CLUSTER=madripoor
clean_quay_madripoor: clean_quay

clean_quay_wakanda: CLUSTER=wakanda
clean_quay_wakanda: clean_quay

clean_quay_metropolis: CLUSTER=metropolis
clean_quay_metropolis: clean_quay

clean_quay:
	@BEARER=00UKUIFF1MSEFZ6SWQCUMK8KK79WA3GAOYZ7GGI7 ; \
	for team in 1 2 3 4 5 6; do \
	  for svc in hero villain fight ; do \
	  	echo "Cleaning $(CLUSTER)/devteam$${team}-$${svc}" ; \
	    curl -X DELETE -H "Authorization: Bearer $$BEARER"   "https://quay.apps.cluster-8sprz.8sprz.sandbox2184.opentlc.com/api/v1/repository/$(CLUSTER)/devteam$${team}-$${svc}" ; \
	  done ; \
	done


