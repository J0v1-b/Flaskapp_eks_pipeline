apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-flask-app
  labels:
    app: my-flask-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-flask-app
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: my-flask-app
    spec:
      containers:
      - name: my-flask-app
        image: my-flask-app:latest
        ports:
        - containerPort: 5000
        env:
        - name: PYTHONUNBUFFERED
          value: "1"
        resources:
          limits:
            cpu: "500m"
            memory: "1Gi"
          requests:
            cpu: "250m"
            memory: "512Mi"
        securityContext:
          runAsUser: 1000
          runAsGroup: 1000
          capabilities:
            drop:
            - ALL
            add:
            - NET_BIND_SERVICE
        readinessProbe:
          httpGet:
            path: /health
            port: 5000
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /health
            port: 5000
          initialDelaySeconds: 30
          periodSeconds: 10
      serviceAccountName: my-flask-app
      imagePullSecrets:
        - name: my-flask-app-secret
