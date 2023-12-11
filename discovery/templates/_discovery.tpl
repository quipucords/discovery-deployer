{{/*
Define the global Service Account name to use for Discovery and its subcharts.
*/}}
{{- define "discovery.globalServiceAccountName" -}}
{{- printf "%s-%s" .Release.Name .Values.global.serviceAccountNameSuffix }}
{{- end }}

{{/*
Define the full name of the discovery-server
*/}}
{{- define "discovery.serverFullname" -}}
{{- printf "%s-discovery-server" (include "discovery.fullname" .) }}
{{- end }}
