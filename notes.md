flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=kubernetes-home \
  --branch=main \
  --path=./clusters/home \
  --personal


flux create helmrelease nfs-subdir-external-provisioner \
    --source=HelmRepository/nfs-subdir-external-provisioner \
    --chart nfs-subdir-external-provisioner \
    --release-name nfs-subdir-external-provisioner \
    --target-namespace default \
    --interval 1440m0s \
    --export > clusters/home/nfs-subdir-external-provisioner/helmrelease.yaml


flux create helmrelease nfs-subdir-external-provisioner \
    --source=HelmRepository/nfs-subdir-external-provisioner \
    --chart nfs-subdir-external-provisioner \
    --release-name nfs-subdir-external-provisioner \
    --target-namespace default \
    --interval 1440m0s \
    --export > clusters/home/nfs-subdir-external-provisioner/helmrelease.yaml

flux create source helm traefik \
    --url https://traefik.github.io/charts \
    --interval 24h0m0s \
    --export > clusters/home/helm-repos/traefik.yaml

flux create helmrelease traefik \
    --source=HelmRepository/traefik \
    --chart traefik \
    --release-name traefik \
    --target-namespace default \
    --interval 1440m0s \
    --export > clusters/home/traefik/helmrelease.yaml




flux create source helm cert-manager \
    --url https://charts.jetstack.io \
    --interval 24h0m0s \
    --export > clusters/home/core/helm-repos/cert-manager.yaml



flux create helmrelease jetstack \
    --source=HelmRepository/cert-manager \
    --chart cert-manager \
    --release-name cert-manager \
    --target-namespace cert-manager \
    --interval 1440m0s \
    --export > clusters/home/core/cert-manager/helmrelease.yaml



flux create helmrelease transmission \
    --source=HelmRepository/geek-cookbook \
    --chart transmission \
    --release-name transmission \
    --target-namespace home-services \
    --interval 1440m0s \
    --export > clusters/home/core/home-services/helmrelease.yaml










# Create age secret
cat ~/.sops/age.agekey |
kubectl create secret generic sops-age \
--namespace=flux-system \
--from-file=age.agekey=/dev/stdin

encrypt secret:
sops --encrypt -age --in-place core/cert-manager/cloudflare-token-secret.yaml