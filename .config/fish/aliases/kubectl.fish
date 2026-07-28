# Namespace management
function kcn-set
	echo $argv[1] > $HOME/.tmp/kubectl-namespace
end

function kcn-unset
	rm $HOME/.tmp/kubectl-namespace
end

function kcn-get
	cat $HOME/.tmp/kubectl-namespace 2>/dev/null
end

function kg
	cat $HOME/.tmp/kubectl-namespace 2>/dev/null
end

function kcn
	if test -z "$argv[1]"
		set -l ns (kcn-get)
		if test -z "$ns"
			echo "Namespace: NOT SET"
		else
			echo "Namespace: $ns"
		end
	else
		echo $argv[1] > $HOME/.tmp/kubectl-namespace
		echo "Namespace set to "(kcn-get)
	end
end

# Kubernetes aliases
alias kc 'kubectl'

function kcin
	kubectl -n (kcn-get) $argv
end

function kcing
	kubectl -n (kcn-get) get $argv
end

function kcine
	kubectl -n (kcn-get) edit $argv
end

function kcind
	kubectl -n (kcn-get) delete $argv
end

function kcindf
	kubectl -n (kcn-get) delete --force --grace-period=0 $argv
end

function kcindr
	kubectl -n (kcn-get) describe $argv
end

function kcinsc
	kubectl -n (kcn-get) scale $argv
end

alias kc-c "kubectl config get-contexts"
alias kc-cu "kubectl config use"
alias kcns "kubectl get ns"
alias kci-all "kubectl get ing -A -o json | jq -r '.items[].spec.rules[].host'"

function kcon
	echo "On cluster: "(kubectl config get-contexts | grep '*' | cut -d ' ' -f10)" | Namespace: "(kcn-get)
end

# Kubectl aliases
function kcp
	kubectl get pods -n (kcn-get) $argv
end

function kcp-containers
	if test -z "$argv[1]"
		echo "Specify pod name"
		return 1
	end

	echo "Containers in $argv[1]: "(kubectl get pods -n (kcn-get) $argv[1] -o jsonpath='{.spec.containers[*].name}')
	echo "Initialization containers: "(kubectl get pods -n (kcn-get) $argv[1] -o jsonpath='{.spec.initContainers[*].name}')
end

function kcp-ef
	kubectl get pods -n (kcn-get) --field-selector "status.phase!=Failed" $argv
end

function kcpd
	kubectl get pod -n (kcn-get) -o yaml $argv
end

function kcpa
	kubectl get pods -n (kcn-get) $argv
end

function kcdep
	kubectl get deployments -n (kcn-get) $argv
end

function kcdep-resources
	kubectl get deployments -n (kcn-get) -o json | jq -r '.items[] | "\(.metadata.name): cpu req/lim = \(.spec.template.spec.containers[0].resources.requests.cpu)/\(.spec.template.spec.containers[0].resources.limits.cpu) | mem req/lim: \(.spec.template.spec.containers[0].resources.requests.memory)/\(.spec.template.spec.containers[0].resources.limits.memory)"'
end

function kcEdep
	kubectl edit deployments -n (kcn-get) $argv
end

function kci
	kubectl get ing -n (kcn-get) $argv
end

function kcmcrt
	kubectl get mcrt -n (kcn-get) $argv
end

function kcmcrt-status
	if test -z "$argv[1]"
		kubectl get mcrt -n (kcn-get) -o json | jq -r '.items[] | "\(.metadata.name) - \(.status.certificateName) - \(.status.certificateStatus) - \(.status.domainStatus[].domain): \(.status.domainStatus[].status)"'
	else
		kubectl get mcrt -n (kcn-get) -o json $argv[1] | jq -r '"\(.metadata.name) - \(.status.certificateName) - \(.status.certificateStatus) - \(.status.domainStatus[].domain): \(.status.domainStatus[].status)"'
	end
end

function kcmcrt-status-watch
	set -l ns (kcn-get)
	if test -z "$argv[1]"
		watch -n 1 "kubectl get mcrt -n $ns -o json | jq -r '.items[] | \"\(.metadata.name) - \(.status.certificateName) - \(.status.certificateStatus) - \(.status.domainStatus[].domain): \(.status.domainStatus[].status)\"'"
	else
		watch -n 1 "kubectl get mcrt -n $ns -o json $argv[1] | jq -r '\"\(.metadata.name) - \(.status.certificateName) - \(.status.certificateStatus) - \(.status.domainStatus[].domain): \(.status.domainStatus[].status)\"'"
	end
end

function kccert
	kubectl get certs -n (kcn-get) $argv
end

function kcpv
	kubectl get pv -n (kcn-get) $argv
end

function kcpvc
	kubectl get pvc -n (kcn-get) $argv
end

function kcsvc
	kubectl get services -n (kcn-get) $argv
end

function kcev
	kubectl get events -n (kcn-get) --sort-by='{.lastTimestamp}' $argv
end

function kcevw
	kubectl get events -n (kcn-get) --sort-by='{.lastTimestamp}' --watch $argv
end

function kcinsec
	if test -z "$argv[1]"
		echo "Specify a secret name"
		return 1
	end

	kcing secret $argv[1] -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d )"'
end

#function kca
#	set -l resources "configmaps,limitranges,namespaces,persistentvolumeclaims,persistentvolumes,pods,secrets,serviceaccounts,services,daemonsets,deployments,replicasets,statefulsets,horizontalpodautoscalers,cronjobs,jobs,ingresses,clusterrolebindings,clusterroles,rolebindings,roles,storageclasses"
#	kubectl get $resources -n (kcn-get)
#end

function kca
	set -l resources (kubectl api-resources --namespaced=true --verbs=get -o name | tr '\n' ',' | sed '$ s/,$//g')
	kubectl -n (kcn-get) get $resources $argv
end

function kce
	kubectl exec -itn (kcn-get) $argv[1] -- $argv[2]
end

function kces
	kubectl exec -itn (kcn-get) $argv[1] sh
end

function kcl
	set -l tailsize 50
	if set -q argv[2]
		set tailsize $argv[2]
	end

	if test -z "$argv[3]"
		kubectl logs -n (kcn-get) --tail=$tailsize $argv[1]
	else
		kubectl logs -n (kcn-get) --tail=$tailsize -c $argv[3] $argv[1]
	end
end

function kclt
	set -l tailsize 50
	if set -q argv[2]
		set tailsize $argv[2]
	end

	if test -z "$argv[3]"
		kubectl logs -n (kcn-get) --follow --tail=$tailsize $argv[1]
	else
		kubectl logs -n (kcn-get) --follow --tail=$tailsize -c $argv[3] $argv[1]
	end
end

function kcla
	kubectl logs -n (kcn-get) --all-containers $argv
end

function kclta
	kubectl logs -n (kcn-get) -f --all-containers --max-log-requests=10 $argv
end

function kctp
	kubectl top pods -n (kcn-get)
end

function kctpa
	kubectl top pods -A
end

function kctpa-filterlow
	kubectl top pods -A | grep -v -e " 1m " -e " 2m " -e " 3m " -e " 4m " -e " 5m " -e " 6m " -e " 7m " -e " 8m " -e " 9m " -e " 0m "
end

function kctn
	kubectl top nodes
end

function kcsarb
	kubectl get rolebindings,clusterrolebindings -A -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'
end

# k8s management aliases

function kcm-top
	kubectl top nodes
end

function kcm-broken-pods
	kubectl get pods -A --field-selector "status.phase=Failed" -o wide
end

function kcm-broken-pods-remove
	kubectl get pods -A --field-selector "status.phase=Failed" --template '{{range .items}}kubectl delete pod -n {{.metadata.namespace}} {{.metadata.name}} &{{"\n"}}{{end}}'
end

function kcm-broken-pods-remove-forced
	kubectl get pods -A --field-selector "status.phase=Failed" --template '{{range .items}}kubectl delete pod -n {{.metadata.namespace}} --force --grace-period=0 {{.metadata.name}} &{{"\n"}}{{end}}'
end

# Deprecation checks

function kcd-certmanager
	kubectl get ingress --all-namespaces -o json | \
	jq '.items[] | select(.metadata.annotations| to_entries | map(.key)[] | test("certmanager")) | "Ingress resource \(.metadata.namespace)/\(.metadata.name) contains old annotations: (\( .metadata.annotations | to_entries | map(.key)[] | select( . | test("certmanager") )  ))"'
end

# Check deprecations on DaemonSet (daemonsets: extensions/v1beta, apps/v1beta2 => apps/v1)
# Check deprecations on Deployment (deployments: extensions/v1beta1, apps/v1beta1, apps/v1beta2 => apps/v1)
# Check deprecations on ReplicaSet (replicasets: extensions/v1beta1, apps/v1beta1, apps/v1beta2 => apps/v1)
# Check deprecations on StatefulSet (statefulsets: apps/v1beta1, apps/v1beta2 => apps/v1)
# Check deprecations on NetworkPolicy (networkpolicies: extensions/v1beta1 => networking.k8s.io/v1)
# Check deprecations on PodSecurityPolicy (podsecuritypolicies: extensions/v1beta1 => policy/v1beta1)
function kcd-k8s-v1-16
	kubectl get daemonsets -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta|extensions/v1beta1|apps/v1beta2)$")) | "DaemonSet resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use apps/v1 instead"'

	kubectl get deployments -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta1|apps/v1beta1|apps/v1beta2)$")) | "Deployment resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use apps/v1 instead"'

	kubectl get replicasets -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta1|apps/v1beta1|apps/v1beta2)$")) | "ReplicaSet resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use apps/v1 instead"'

	kubectl get statefulsets -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(apps/v1beta1|apps/v1beta2)$")) | "StatefulSet resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use apps/v1 instead"'

	kubectl get networkpolicies -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta1)$")) | "NetworkPolicy resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use networking.k8s.io/v1 instead"'

	kubectl get podsecuritypolicies -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta1)$")) | "PodSecurityPolicy resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use policy/v1beta1 instead"'
end

function kcd-k8s-v1-22
	kubectl get csidriver,csinode,storageclass,volumeattachment -A -o json | \
	jq '.items[] | select(.apiVersion| test("^storage.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get priorityclass -A -o json | \
	jq '.items[] | select(.apiVersion| test("^scheduling.k8s.io/v1beta1$")) | "PriorityClass resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get clusterrole,clusterrolebinding,role,rolebinding -A -o json | \
	jq '.items[] | select(.apiVersion| test("^rbac.authorization.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get ingressclass -A -o json | \
	jq '.items[] | select(.apiVersion| test("^networking.k8s.io/v1beta1$")) | "IngressClass resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get ingress -A -o json | \
	jq '.items[] | select(.apiVersion| test("^(extensions/v1beta1|networking.k8s.io/v1beta1)$")) | "Ingress resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get lease -A -o json | \
	jq '.items[] | select(.apiVersion| test("^coordination.k8s.io/v1beta1$")) | "Lease resource \(.metadata.namespace)/\(.metdata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get certificatesigningrequest -A -o json | \
	jq '.items[] | select(.apiVersion| test("^certificates.k8s.io/v1beta1$")) | "CertificateSigningRequest \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get localsubjectaccessreview,selfsubjectaccessreview,subjectaccessreview -A -o json | \
	jq '.items[] | select(.apiVersion| test("^authorization.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get tokenreview -A -o json | \
	jq '.items[] | select(.apiVersion| test("^authentication.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get apiservice -A -o json | \
	jq '.items[] | select(.apiVersion| test("^apiregistration.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get customresourcedefinition -A -o json | \
	jq '.items[] | select(.apiVersion| test("^apiextensions.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'

	kubectl get mutatingwebhookconfiguration,validatingwebhookconfiguration -A -o json | \
	jq '.items[] | select(.apiVersion| test("^admissionregistration.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22)"'
end

function kcd-k8s-v1-25
	kubectl get runtimeclass -A -o json | \
	jq '.items[] | select(.apiVersion| test("^node.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'

	kubectl get podsecuritypolicy -A -o json | \
	jq '.items[] | select(.apiVersion| test("^policy/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'

	kubectl get poddisruptionbudget -A -o json | \
	jq '.items[] | select(.apiVersion| test("^policy/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'

	kubectl get event -A -o json | \
	jq '.items[] | select(.apiVersion| test("^events.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'

	kubectl get endpointslice -A -o json | \
	jq '.items[] | select(.apiVersion| test("^discovery.k8s.io/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'

	kubectl get cronjob -A -o json | \
	jq '.items[] | select(.apiVersion| test("^batch/v1beta1$")) | "Resource \(.metadata.namespace)/\(.metadata.name) contains deprecated apiVersion: \(.apiVersion), please use alternative (see: https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25)"'
end

# List all pods with namespace and phase of pod
#kc get pods -A -o json | jq '.items[] | "\(.metadata.name) (\(.metadata.namespace)) status \(.status.phase)"'

# List all pods with namespace and phase of pod but filter on phase
#kc get pods -A -o json | jq '.items[] | select(.status.phase == "Pending") |  "\(.metadata.name) (\(.metadata.namespace)) status \(.status.phase)"'

# Apply resource limiting to all namespaces (note, do not do this for system namespaces)
function kcm-limitrange-all-namespaces
	kubectl get namespaces -o json | jq -r '.items[] | "kubectl create -n \(.metadata.name) -f default-limit-range.yaml"'
end

# Helm
function h
	helm $argv
end

function hn
	helm -n (kcn-get) $argv
end

function hls
	helm -n (kcn-get) ls $argv
end

function hals
	helm ls --all-namespaces
end

function hgv
	helm -n (kcn-get) get values
end

function hd
	helm -n (kcn-get) delete
end

# Helmfile
function hf
	helmfile $argv
end

# Port forward rabbitmq
function kc-pf-rmq
	set -l podName (kubectl -n (kcn-get) get pods --selector=app=rabbitmq -o json | jq -r '.items[0].metadata.name')
	if test -z "$podName"
		echo "Could not find rabbitmq pod"
		return 1
	end
	set -l adminUser (kubectl -n (kcn-get) get secret rabbitmq-secrets -o json | jq -r .data.RABBITMQ_ADMIN_USER | base64 -d)
	set -l adminPass (kubectl -n (kcn-get) get secret rabbitmq-secrets -o json | jq -r .data.RABBITMQ_ADMIN_PASS | base64 -d)
	echo "Opening port to RabbitMQ at http://localhost:25672."
	echo "Username: $adminUser"
	echo "Password: $adminPass"
	kubectl -n (kcn-get) port-forward $podName 25672:15672
end
