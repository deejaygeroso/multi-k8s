docker build -t deejaygeroso/multi-client:latest -t deejaygeroso/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deejaygeroso/multi-server:latest -t deejaygeroso/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deejaygeroso/multi-worker:latest -t deejaygeroso/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deejaygeroso/multi-client:latest
docker push deejaygeroso/multi-server:latest
docker push deejaygeroso/multi-worker:latest

docker push deejaygeroso/multi-client:$SHA
docker push deejaygeroso/multi-server:$SHA
docker push deejaygeroso/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/client-deployment client=deejaygeroso/multi-client:$SHA
kubectl set image deployments/server-deployment server=deejaygeroso/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=deejaygeroso/multi-worker:$SHA
