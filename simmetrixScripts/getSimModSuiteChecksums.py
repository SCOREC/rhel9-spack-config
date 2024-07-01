#!/usr/bin/python

import os, sys
import hashlib

def md5(fname, debug):
  if debug:
     print("fname", fname)
  hash_256 = hashlib.sha256()
  with open(fname, "rb") as f:
    for chunk in iter(lambda: f.read(4096), b""):
        hash_256.update(chunk)
    return hash_256.hexdigest()

if len(sys.argv) != 3 and len(sys.argv) != 4:
  print("Usage: {0} <version string> </path/to/tarballs> [debug=off|on]".format(sys.argv[0]))
  sys.exit() 

version = sys.argv[1]
path = sys.argv[2]
debug = False
if len(sys.argv) == 4 and sys.argv[3] == "on":
  debug = True
dirs = os.listdir( path )

componentToLicense = { 
    'mscore': 'base',
    'fdcore': 'base',
    'gmcore': 'base',
    'msadapt': 'base',
    'simlicense': 'base',
    'opencascade': 'opencascade',
    'aciskrnl': 'acis',
    'psint': 'parasolid',
    'pskrnl': 'parasolid',
    'discrete': 'discrete',
    'gmabstract': 'abstract',
    'gmadv': 'advmodel',
    'gmvoxel': 'voxel',
    'msadv': 'adv',
    'mscrack': 'crack',
    'octree': 'octree',
    'msparalleladapt': 'paralleladapt',
    'msparallelmesh': 'parallelmesh',
    'FieldSim': 'base',
    'GeomSim': 'base',
    'MeshSim': 'base',
    'MeshSimAdapt': 'base',
    'MeshSimAdv': 'adv',
    'MeshSimAdvanced': 'adv',
    'MeshSimOctree': 'octree',
    'MeshSimCrack': 'crack',
    'GeomSimAcis': 'acis',
    'GeomSimParasolid': 'parasolid',
    'GeomSimDiscrete': 'discrete',
    'GeomSimDiscreteModeling': 'discrete',
    'GeomSimAbstract': 'abstract',
    'GeomSimAdvanced': 'advmodel',
    'GeomSimImport': 'import',
    'GeomSimVoxel': 'voxel',
    'GeomSimSolidWorks': 'parasolid',
    'GeomSimGranite': 'granite',
    'GeomSimOpenCascade': 'opencascade',
    'MeshSimAdvanced': 'adv',
    'ParallelMeshSimAdapt': 'paralleladapt',
    'ParallelMeshSim': 'parallelmesh',
    'xgcadios': 'adv',
    'ace3p': 'adv',
    'exodus': 'adv',
    'discretemodeling': 'discrete'
    }


resource = '       \'{name}\': [\'{md5}\', \'{lic}\'],'
components = ''
docs = ''
# components
for file in dirs:
   if ".tgz" in file:
      if debug:
         print("file:", file)
      name = file.split('-')[0]
      d = {
       'name': name,
       'md5': md5(path+file, debug),
       'lic': componentToLicense[name]
      }
      line = resource.format(**d)
      if components != "":
        components = components + '\n' + line
      else:
        components = line
   if ".zip" in file:
      if debug:
         print("file", file)
      name = file.split('.')[0]
      d = {
       'name': name,
       'md5': md5(path+file, debug),
       'lic': componentToLicense[name]
      }
      line = resource.format(**d)
      if docs != "":
         docs = docs + '\n' + line
      else:
         docs = line

release = \
'''{{
    \'version\': \'{version}\',
    \'components\': {{
{components}
    }},
    \'docs\': {{
{docs}
    }}
}},'''

d = {
 'version': version, 
 'components': components,
 'docs': docs
}
print(release.format(**d))
