docker build -t alexcmachado/multi-client:latest -t alexcmachado/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexcmachado/multi-server:latest -t alexcmachado/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexcmachado/multi-worker:latest -t alexcmachado/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexcmachado/multi-client:latest
docker push alexcmachado/multi-server:latest
docker push alexcmachado/multi-worker:latest

docker push alexcmachado/multi-client:$SHA
docker push alexcmachado/multi-server:$SHA
docker push alexcmachado/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexcmachado/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexcmachado/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexcmachado/multi-worker:$SHA