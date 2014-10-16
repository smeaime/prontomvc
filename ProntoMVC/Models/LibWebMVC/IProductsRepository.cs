using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Northwind.Model;

namespace Northwind.Repositories
{
    public interface IProductsRepository
    {
        void Add(ref Product item);
        void Delete(int key);
        Product FindByKey(int key);
        IEnumerable<Product> FindAll();
        IEnumerable<Product> Find(string filterExpression);
        IEnumerable<Product> FindRange(string filterExpression, string sortingExpression, int startIndex, int count);
        int GetCount(string filterExpression);
        void SaveChanges();
    }
}
