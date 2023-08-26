using System.Collections.Generic;
using UnityEngine;

public class EntityMeshCache : MonoBehaviour
{
    [Header("This collection is filled on import. Do not edit manually")]
    [SerializeField]
    protected List<CachedMeshData> collection;

}
