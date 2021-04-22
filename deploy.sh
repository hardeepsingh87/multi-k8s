docker build -t hardeepsingh87/multi-client:latest -t hardeepsingh87/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hardeepsingh87/multi-server:latest -t hardeepsingh87/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hardeepsingh87/multi-worker:latest -t hardeepsingh87/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hardeepsingh87/multi-client:latest
docker push hardeepsingh87/multi-server:latest
docker push hardeepsingh87/multi-worker:latest

docker push hardeepsingh87/multi-client:$SHA
docker push hardeepsingh87/multi-server:$SHA
docker push hardeepsingh87/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hardeepsingh87/multi-server:$SHA
kubectl set image deployments/client-deployment client=hardeepsingh87/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hardeepsingh87/multi-worker:$SHA

