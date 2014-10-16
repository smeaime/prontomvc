using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Northwind.Model;

namespace Northwind.Repositories.Entity
{
    public class SuppliersRepository : ISuppliersRepository
    {
        #region Fields
        private NorthwindContext _context = new NorthwindContext();
        #endregion

        #region ISuppliersRepository Members
        public Supplier FindByKey(int key)
        {
            return _context.Suppliers.FirstOrDefault(s => s.Id == key);
        }

        public IEnumerable<Supplier> FindAll()
        {
            return _context.Suppliers; //.OrderBy( "Name");
        }
        #endregion
    }
}
