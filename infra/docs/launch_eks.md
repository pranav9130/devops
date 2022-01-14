## [**Launch EKS**](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)

### *Prerequisites*
- [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
- [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)

### Steps to launch cluster with eksctl

1. Create Managed Node Group & Control Plane ( Basically ... complete cluster )    
    - AWS provides two types of managed node groups - fargate/linux ec2. We will be looking more into linux ec2.

    > eksctl create cluster \\ \
        --name test-eks-cluster \\ \
        --region us-east-2 \\ \
        --with-oidc \\ \
        --spot \\ \
        --instance-types=m4.large \\ \
        --nodes-max=2 \\ \
        --ssh-access \\ \
        --ssh-public-key ec2_keypair

### Multi tenant EKS Cluster
- Multi tenancy: Allow multiple users/teams to operate on same cluster with a level of isolation between them.
- Options to achive multi tenancy
    - Multiple single tenant clusters
    - Single EKS clusters with multiple namespaces
- More on the second option is explored below

#### [Single EKS clusters with multiple namespaces](https://aws.amazon.com/blogs/containers/multi-tenant-design-considerations-for-amazon-eks-clusters/

- Compute Isolation
    - Kubernetes documentation defines Namespaces as “a way to divide cluster resources between multiple users” – and thus are foundational for multi-tenancy.
![Alt text](../images/eks_namespaces.png?raw=true "EKS Namepsaces")
    - "Role based access control" defines who can do what on Kuberntes APIs/resources.
    - Role can be bound to cluster level, or at namespace level.
    - For example, we can define a role called namespace1-admin to be used to provide administrator access to one namespace called namespace1, and associate it with a group named admin-ns1.
    - One can map IAM users and roles to RBAC groups
    - Resource Quotas allow users to limit the amount of resources or Kubernetes objects that can be consumed within one namespace.
    - Tenants should be isolated also from access to the underlying node instance. 
    - Kubernetes Pod Security Policy (PSP) allows users to do so.
    - For pod scheduling/allocation isloation - namespaces should be used. For advanced scenarios, one can use "taints & tolerations"
- Network Isolation
    - Kubernetes provides Network Policies that allow user to define fine-grained control over the pod-to-pod communication.
    - Service meshes can allow also to define an additional model of protection that can even span outside of the single EKS cluster. Istio is a very popular open-source service mesh, that provides features as traffic management, security and observability. 
- Storage Isolation
    -  Disable the local volume access all together in a multi-tenant design with PSPs.
    - The PVC is defined as a Namespaced resource – and thus can provide a way to control tenancy access to storage. Administrator can use Storage Resource Quotas to define storage classes that belong to specific Namespaces.