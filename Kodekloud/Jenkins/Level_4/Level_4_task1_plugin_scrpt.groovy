for (plugin in ["ssh",
		"ssh-credentials",
		"ssh-slaves",
		"workflow-aggregator",
		"workflow-job",
		"workflow-cps",
		"pipeline-stage-step",
		"pipeline-build-step",
		"pipeline-model-definition",
		"pipeline-stage-view",
		"ssh-steps",
		"pipeline-graph-view",
		"credentials",
		"badge",
		"mailer",
		"metrics",
		"metricantisamy-markup-formatter"
		"commons-text-api",
		"commons-text-apihandy-uri-templates-2-api",
		"commons-lang3-api",
		"handy-uri-templates-2-api",
		"authentication-tokens",
		"git",
		"git-client"
		"groovy-postbuild",
		"javadoc",
		"parameterized-trigger",
		"view-job-filters"]) {
	e = Hudson.instance.updateCenter.getPlugin(plugin).deploy().get().getError()
	if (e != null)
		println e.message
}
