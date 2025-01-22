```
import sys, json, argparse

parser = argparse.ArgumentParser('Replaces image in the task definition')
parser.add_argument('image_uri', metavar='I', type=str, nargs='+',
                   help='The new image URI')

args = parser.parse_args()

definition = json.load(sys.stdin)['taskDefinition']['containerDefinitions']
definition[0]['image'] = args.image_uri[0]
print(json.dumps(definition))
```