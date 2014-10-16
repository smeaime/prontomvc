//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Globalization;
using System.Runtime.Serialization;

namespace ProntoMVC.Models
{
    [DataContract(IsReference = true)]
    [KnownType(typeof(aspnet_Paths))]
    public partial class aspnet_PersonalizationAllUsers: IObjectWithChangeTracker, INotifyPropertyChanged
    {
        #region Primitive Properties
    
        [DataMember]
        public System.Guid PathId
        {
            get { return _pathId; }
            set
            {
                if (_pathId != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'PathId' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    if (!IsDeserializing)
                    {
                        if (aspnet_Paths != null && aspnet_Paths.PathId != value)
                        {
                            aspnet_Paths = null;
                        }
                    }
                    _pathId = value;
                    OnPropertyChanged("PathId");
                }
            }
        }
        private System.Guid _pathId;
    
        [DataMember]
        public byte[] PageSettings
        {
            get { return _pageSettings; }
            set
            {
                if (_pageSettings != value)
                {
                    _pageSettings = value;
                    OnPropertyChanged("PageSettings");
                }
            }
        }
        private byte[] _pageSettings;
    
        [DataMember]
        public System.DateTime LastUpdatedDate
        {
            get { return _lastUpdatedDate; }
            set
            {
                if (_lastUpdatedDate != value)
                {
                    _lastUpdatedDate = value;
                    OnPropertyChanged("LastUpdatedDate");
                }
            }
        }
        private System.DateTime _lastUpdatedDate;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public aspnet_Paths aspnet_Paths
        {
            get { return _aspnet_Paths; }
            set
            {
                if (!ReferenceEquals(_aspnet_Paths, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added && value != null)
                    {
                        // This the dependent end of an identifying relationship, so the principal end cannot be changed if it is already set,
                        // otherwise it can only be set to an entity with a primary key that is the same value as the dependent's foreign key.
                        if (PathId != value.PathId)
                        {
                            throw new InvalidOperationException("The principal end of an identifying relationship can only be changed when the dependent end is in the Added state.");
                        }
                    }
                    var previousValue = _aspnet_Paths;
                    _aspnet_Paths = value;
                    Fixupaspnet_Paths(previousValue);
                    OnNavigationPropertyChanged("aspnet_Paths");
                }
            }
        }
        private aspnet_Paths _aspnet_Paths;

        #endregion
        #region ChangeTracking
    
        protected virtual void OnPropertyChanged(String propertyName)
        {
            if (ChangeTracker.State != ObjectState.Added && ChangeTracker.State != ObjectState.Deleted)
            {
                ChangeTracker.State = ObjectState.Modified;
            }
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        protected virtual void OnNavigationPropertyChanged(String propertyName)
        {
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged{ add { _propertyChanged += value; } remove { _propertyChanged -= value; } }
        private event PropertyChangedEventHandler _propertyChanged;
        private ObjectChangeTracker _changeTracker;
    
        [DataMember]
        public ObjectChangeTracker ChangeTracker
        {
            get
            {
                if (_changeTracker == null)
                {
                    _changeTracker = new ObjectChangeTracker();
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
                return _changeTracker;
            }
            set
            {
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging -= HandleObjectStateChanging;
                }
                _changeTracker = value;
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
            }
        }
    
        private void HandleObjectStateChanging(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                ClearNavigationProperties();
            }
        }
    
        protected bool IsDeserializing { get; private set; }
    
        [OnDeserializing]
        public void OnDeserializingMethod(StreamingContext context)
        {
            IsDeserializing = true;
        }
    
        [OnDeserialized]
        public void OnDeserializedMethod(StreamingContext context)
        {
            IsDeserializing = false;
            ChangeTracker.ChangeTrackingEnabled = true;
        }
    
        // This entity type is the dependent end in at least one association that performs cascade deletes.
        // This event handler will process notifications that occur when the principal end is deleted.
        internal void HandleCascadeDelete(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                this.MarkAsDeleted();
            }
        }
    
        protected virtual void ClearNavigationProperties()
        {
            aspnet_Paths = null;
        }

        #endregion
        #region Association Fixup
    
        private void Fixupaspnet_Paths(aspnet_Paths previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && ReferenceEquals(previousValue.aspnet_PersonalizationAllUsers, this))
            {
                previousValue.aspnet_PersonalizationAllUsers = null;
            }
    
            if (aspnet_Paths != null)
            {
                aspnet_Paths.aspnet_PersonalizationAllUsers = this;
                PathId = aspnet_Paths.PathId;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("aspnet_Paths")
                    && (ChangeTracker.OriginalValues["aspnet_Paths"] == aspnet_Paths))
                {
                    ChangeTracker.OriginalValues.Remove("aspnet_Paths");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("aspnet_Paths", previousValue);
                }
                if (aspnet_Paths != null && !aspnet_Paths.ChangeTracker.ChangeTrackingEnabled)
                {
                    aspnet_Paths.StartTracking();
                }
            }
        }

        #endregion
    }
}
