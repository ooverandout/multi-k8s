docker build -t ooverandout/multi-client:latest -t ooverandout/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t	ooverandout/multi-server:latest -t ooverandout/multi-server:$SHA -f ./server/Dockerfile	./server
docker build -t ooverandout/multi-worker:latest -t ooverandout/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ooverandout/multi-client:latest
docker push ooverandout/multi-server:latest
docker push ooverandout/multi-worker:latest

docker push ooverandout/multi-client:$SHA
docker push ooverandout/multi-server:$SHA
docker push ooverandout/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ooverandout/multi-server:$SHA
kubectl set image deployments/client-deployment client=ooverandout/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ooverandout/multi-worker:$SHA


