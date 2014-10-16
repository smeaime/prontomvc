using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using Northwind.Model;
using System.Diagnostics;

namespace Northwind.Repositories.Entity
{
    public class ProductsRepository : IProductsRepository
    {
        #region Fields
        private NorthwindContext _context = new NorthwindContext();
        #endregion

        #region IProductsRepository Members
        public void Add(ref Product item)
        {
           _context.Products.Add(item);
        }

        public void Delete(int key)
        {
            _context.Products.Remove(_context.Products.FirstOrDefault(p => p.Id == key));
        }

        public Product FindByKey(int key)
        {
            return _context.Products.FirstOrDefault(p => p.Id == key);
        }

        public IEnumerable<Product> FindAll()
        {
            return _context.Products
                .Include(p => p.Category)
                .Include(p => p.Supplier);
        }

        public IEnumerable<Product> Find(string filterExpression)
        {
            if (!String.IsNullOrWhiteSpace(filterExpression))
                return _context.Products
                    //.Where(filterExpression)
                    .Include(p => p.Category)
                    .Include(p => p.Supplier);
            else
                return _context.Products
                    .Include(p => p.Category)
                    .Include(p => p.Supplier);
        }

        public IEnumerable<Product> FindRange(string filterExpression, string sortingExpression, int startIndex, int count)
        {
            if (!String.IsNullOrWhiteSpace(filterExpression))
                return _context.Products
                    //.Where(filterExpression)
                    .Include(p => p.Category)
                    .Include(p => p.Supplier)
                  //  .OrderBy(sortingExpression)
                    .Skip(startIndex)
                    .Take(count);
            else
                return _context.Products
                    .Include(p => p.Category)
                    .Include(p => p.Supplier)
                   // .OrderBy(sortingExpression)
                    .Skip(startIndex)
                    .Take(count);
        }

        public int GetCount(string filterExpression)
        {
            if (!String.IsNullOrWhiteSpace(filterExpression))
                return _context.Products.Count(); // Where(filterExpression).Count();
            else
                return _context.Products.Count();
        }

        public void SaveChanges()
        {
            _context.SaveChanges();
        }
        #endregion
    }
}
