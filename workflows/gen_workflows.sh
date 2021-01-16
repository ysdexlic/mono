# read the workflow template
WORKFLOW_TEMPLATE=$(cat .github/workflow-template.yaml)

# iterate each route in routes directory
for LIB_APP in $(ls lib); do
    echo "generating workflow for lib/${LIB_APP}"

    WORKFLOW=$(echo "${WORKFLOW_TEMPLATE}" | sed "s/{{LIB_APP}}/${LIB_APP}/g")

    if [[ -f "workflows/${LIB_APP}/workflow.yaml" ]]; then
      WORKFLOW=$(cat workflows/${LIB_APP}/workflow.yaml)
    fi

    echo "${WORKFLOW}" > .github/workflows/${LIB_APP}.yaml
done

