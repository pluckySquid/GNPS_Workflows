#!/usr/bin/env nextflow

params.input = "feature-based-molecular-networking/input.xml"

// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/tools/feature-based-molecular-networking"

params.livesearchDownload = "http://example.com/download" // replace with your URL
params.task = "mytask" // replace with your task parameter value
params.user = "myuser" // replace with your user parameter value

process download {
    output:
    tuple val(spec), val(quantification_table), val(raw_spectra), val(metadata_table), val(additional_pairs), val(lib), val(flowParams)

    script:
    """
    curl -L "${params.livesearchDownload}?task=${params.task}&user=${params.user}" -o data.zip
    unzip data.zip
    """

    """
    # assume that the unzipped data has the following directory structure
    # data/
    #   feature/
    #   spectrum/
    #   library/
    #   metadata/
    #   additional/
    mv data/spectrum/* ${spec}
    mv data/feature/* ${quantification_table}
    mv data/library/* ${lib}
    mv data/metadata/* ${metadata_table}
    mv data/additional/* ${additional_pairs}
    mv data/params ${flowParams}
    """
}
