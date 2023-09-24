{{/* Common labels */}}
{{- define "common.labels" -}}
app: perntodo-api
type: devops-exam
identity_key: {{ .Values.identity_key }}
{{- end }}
