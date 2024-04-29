import json

def update_uris(sarif_file_path):
    with open(sarif_file_path, 'r') as f:
        sarif_data = json.load(f)

    for result in sarif_data['runs'][0]['results']:
        locations = result.get('locations', [])
        for location in locations:
            physical_location = location.get('physicalLocation', {})
            artifact_location = physical_location.get('artifactLocation', {})
            uri = artifact_location.get('uri', '')

            # Check if the URI starts with 'git://'
            if uri.startswith('git://'):
                # Replace 'git://' with 'file://'
                updated_uri = 'file://' + uri[6:]
                artifact_location['uri'] = updated_uri

    # Write the updated SARIF data back to the file
    with open(sarif_file_path, 'w') as f:
        json.dump(sarif_data, f, indent=4)