using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Northwind.Model;

namespace Northwind.Repositories.Entity
{
    public class CategoriesRepository : ICategoriesRepository
    {
        #region Fields
        private NorthwindContext _context = new NorthwindContext();
        #endregion

        #region ICategoriesRepository Members
        public Category FindByKey(int key)
        {
            return _context.Categories.FirstOrDefault(c => c.Id == key);
        }

        public IEnumerable<Category> FindAll()
        {
          return _context.Categories; // .OrderBy("Name");
        }
        #endregion
    }
}