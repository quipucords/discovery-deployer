{{/*
Define the global Service Account name to use for Discovery and its subcharts.
*/}}
{{- define "discovery.globalServiceAccountName" -}}
{{- printf "%s-%s" .Release.Name .Values.global.serviceAccountNameSuffix }}
{{- end }}
