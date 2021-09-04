#! /bin/bash

ZONE=europe-west1-d
CLUSTER_NAME=my-k8s-cluster
NETWORK=default

function help() {
  echo '''
    create_cluster [NUM_NODES]   Create cluster of size NUM_NODES nodes. default is 1
    resize_cluster NUM_NODES     Resize the cluster to NUM_NODES. You must specify the number to resize to
    delete_cluster               Delete the cluster
  '''
}

if [[ $1 == '-h' ]] || [[ $1 == '--help' ]]; then
  help;
fi

# Create the cluster
function create_cluster() {
  NUM_NODE=1
  
  if [[ ! -z $1 ]]; then
    echo $1 is number;
	  NUM_NODE=$1;
  fi

  if [ ! -z $2 ]; then
    NETWORK=$2
  fi

  gcloud container clusters create $CLUSTER_NAME --num-nodes $NUM_NODE --zone $ZONE --network $NETWORK; 
}

# resize the cluster
function resize_cluster() {
  if [[ -z $1 ]]; then
    echo Please provide the number to resize to.;
    return 3;
  fi
  NUM_NODES=$1
  gcloud container clusters resize   $CLUSTER_NAME --num-nodes=$NUM_NODES --zone $ZONE;
}

# Delete the cluster
function delete_cluster() {
	gcloud container clusters delete $CLUSTER_NAME --zone $ZONE;
}
