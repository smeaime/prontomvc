using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Northwind.Model;

namespace Northwind.Repositories
{
    public interface ISuppliersRepository
    {
        Supplier FindByKey(int key);
        IEnumerable<Supplier> FindAll();
    }
}
