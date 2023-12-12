{{/*
Define the global Service Account name to use for Discovery and its subcharts.
*/}}
{{- define "discovery.globalServiceAccountName" -}}
{{- printf "%s-%s" .Release.Name .Values.global.serviceAccountNameSuffix }}
{{- end }}

{{/*
Define the full name of the discovery server
*/}}
{{- define "discovery.serverFullname" -}}
{{- printf "%s-server" (include "discovery.fullname" .) }}
{{- end }}

{{/*
Define the cluster local fully qualified host for the database
*/}}
{{- define "discovery.db-host" -}}
{{ printf "%s-db.%s.svc.cluster.local" (include "discovery.fullname" . ) (.Release.Namespace) }}
{{- end }}

{{/*
Define the cluster local fully qualified host for redis
*/}}
{{- define "discovery.redis-host" -}}
{{ printf "%s-redis.%s.svc.cluster.local" (include "discovery.fullname" . ) (.Release.Namespace) }}
{{- end }}
