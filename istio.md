# Istio
Open source framework for connecting, securing, and managing microservices.  It lets you create a network of deployed services with load balancing, service-to-service authentication, monitoring, and more, without requiring any changes in service code.

The term service mesh is used to describe the network of microservices that make up such applications and the interactions between them. As a service mesh grows in size and complexity, it can become harder to understand and manage. Its requirements can include discovery, load balancing, failure recovery, metrics, and monitoring. A service mesh also often has more complex operational requirements, like A/B testing, canary releases, rate limiting, access control, and end-to-end authentication. Istio provides behavioral insights and operational control over the service mesh as a whole, offering a complete solution to satisfy the diverse requirements of microservice applications.

Core features:
 * Traffic management: lets you control the flow of traffic. Istio simplifies configuration of service-level properties like circuit breakers, timeouts, and retries
 * Security: Istio provides the underlying secure communication channel, and manages authentication, authorization, and encryption of service communication at scale.
 * Observability: Istio’s robust tracing, monitoring, and logging give you deep insights into your service mesh deployment
 * Platform support: You can deploy Istio on Kubernetes, or on Nomad with Consul
 * Integration and customization: The policy enforcement component of Istio can be extended and customized to integrate with existing solutions for ACLs, logging, monitoring, quotas, auditing, and more.


## Components

* Envoy: high-performance proxy developed in C++ to mediate all inbound and outbound traffic for all services in the service mesh.
* Mixer: enforces access control and usage policies across the service mesh, and collects telemetry data from the Envoy proxy and other services.
* Pilot :provides service discovery for the Envoy sidecars, traffic management capabilities for intelligent routing (e.g., A/B tests, canary deployments, etc.), and resiliency (timeouts, retries, circuit breakers, etc.).
* Citadel: provides strong service-to-service and end-user authentication with built-in identity and credential management
* Galley validates user authored Istio API configuration. In the future, it will be responsible for insulating the rest of the Istio components from the details of obtaining user configuration from the underlying platform (e.g. Kubernetes).


## Resources

**RouteRule**

1 - For static routing

```yaml
apiVersion: config.istio.io/v1alpha2
kind: RouteRule
metadata:
  name: reviews-default
spec:
  destination:
    name: reviews
  precedence: 1
  route:
  - labels:
      version: v1
```

2 - For dynamic routing: As the mesh operates at Layer 7, you can use HTTP attributes (paths or cookies) to decide on how to route a request.

```yaml
apiVersion: config.istio.io/v1alpha2
kind: RouteRule
metadata:
  name: reviews-test-v2
spec:
  destination:
    name: reviews
  precedence: 2
  match:
    request:
      headers:
        cookie:
          regex: "^(.*?;)?(user=jason)(;.*)?$"
  route:
  - labels:
      version: v2
```


## Usage

```bash
# Install
kubectl apply -f install/kubernetes/istio-auth.yaml
# deploy service with istio sidecar
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/kube/bookinfo.yaml)
```
