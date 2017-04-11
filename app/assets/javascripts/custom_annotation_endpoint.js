/*
 * annotationsList - current list of OA Annotations
 * dfd - Deferred Object
 * init()
 * search(options, successCallback, errorCallback)
 * create(oaAnnotation, successCallback, errorCallback)
 * update(oaAnnotation, successCallback, errorCallback)
 * deleteAnnotation(annotationID, successCallback, errorCallback)
 *
 * getAnnotationInOA(endpointAnnotation)
 * getAnnotationInEndpoint(oaAnnotation)
 */
(function($){

  $.Endpoint = function(options) {

    jQuery.extend(this, {
      dfd:             null,
      annotationsList: [],  // OA list for Mirador use
      windowID:        null,
      eventEmitter:    null
    }, options);

    this.init();
  };

  $.Endpoint.prototype = {
    init: function() {},

    // Search endpoint for all annotations with a given URI in options
    search: function(options, successCallback, errorCallback) {
      var _this = this;
      _this.annotationsList = [];

      jQuery.ajax({
        url: _this.endpoint,
        type: 'GET',
        dataType: 'json',
        headers: { },
        data: options,  // options.uri contains the Canvas URI
        contentType: "application/json; charset=utf-8",
        success: function(data) {
          if (typeof successCallback === "function") {
            successCallback(data);
          } else {
            jQuery.each(data, function(index, value) {
              _this.annotationsList.push(_this.getAnnotationInOA(value));
            });
            _this.dfd.resolve(true);
          }
        },
        error: function(data) {
          if (typeof errorCallback === "function") {
            errorCallback(data);
          } else {
            console.log("The request for annotations has caused an error for endpoint: " + options.uri);
          }
        }
      });
    },

    // Delete an annotation by endpoint identifier
    deleteAnnotation: function(annotationID, successCallback, errorCallback) {
      var _this = this;
      jQuery.ajax({
        url: _this.endpoint + '/' + annotationID,
        type: 'DELETE',
        dataType: 'json',
        headers: {
          'X-CSRF-Token': _this.csrfToken()
        },
        contentType: "application/json; charset=utf-8",
        success: function(data) {
          if (typeof successCallback === "function") {
            successCallback();
          }
        },
        error: function() {
          if (typeof errorCallback === "function") {
            errorCallback();
          }
        }
      });
    },

    // Update an annotation given the OA version
    update: function(oaAnnotation, successCallback, errorCallback) {
      var annotation = this.getAnnotationInEndpoint(oaAnnotation),
      _this = this;

      jQuery.ajax({
        url: _this.endpoint + '/' + annotationID,
        type: 'PATCH',
        dataType: 'json',
        headers: {
          'X-CSRF-Token': _this.csrfToken()
        },
        data: JSON.stringify(annotation),
        contentType: "application/json; charset=utf-8",
        success: function(data) {
          if (typeof successCallback === "function") {
            successCallback();
          }
        },
        error: function() {
          if (typeof errorCallback === "function") {
            errorCallback();
          }
        }
      });
    },

    // Takes OA Annotation, gets Endpoint Annotation, and saves
    // if successful, MUST return the OA rendering of the annotation
    create: function(oaAnnotation, successCallback, errorCallback) {
      var _this = this;
      var annotation = _this.getAnnotationInEndpoint(oaAnnotation);
      jQuery.ajax({
        url: _this.endpoint,
        type: 'POST',
        headers: {
          'X-CSRF-Token': _this.csrfToken()
        },
        data: JSON.stringify(annotation),
        contentType: "application/json; charset=utf-8",
        success: function(data) {
          if (typeof successCallback === "function") {
            successCallback(_this.getAnnotationInOA(data));
          }
        },
        error: function() {
          if (typeof errorCallback === "function") {
            errorCallback();
          }
        }
      });
    },

    set: function(prop, value, options) {
      if (options) {
        this[options.parent][prop] = value;
      } else {
        this[prop] = value;
      }
    },

    //Convert Endpoint annotation to OA
    getAnnotationInOA: function(annotation) {
      return annotation;
    },

    // Converts OA Annotation to endpoint format
    getAnnotationInEndpoint: function(oaAnnotation) {
      var uuid = Mirador.genUUID();
      oaAnnotation["@id"] = uuid;
      canvas = oaAnnotation.on[0].full;
      return {
        annotation: {
          uuid: uuid,
          data: JSON.stringify(oaAnnotation),
          canvas: canvas
        }
      };    },

    userAuthorize: function(action, annotation) {
      return true;  // allow all
    },

    csrfToken: function() {
      // We need to monkey patch this since $ !== jQuery in Mirador context
      return jQuery('meta[name=csrf-token]').attr('content');
    },

  };

}(Mirador));
